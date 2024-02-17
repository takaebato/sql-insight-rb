use crate::ruby_api::ident::RbIdent;

use std::cell::RefCell;

use crate::ruby_api::root;
use magnus::try_convert::TryConvertOwned;
use magnus::value::ReprValue;
use magnus::{
    class, function, method, Error, IntoValueFromNative, Module, Object, TryConvert, Value,
};
use sql_insight::TableReference;

#[derive(Default, Clone)]
pub struct RbTableReferenceInner {
    catalog: Option<RbIdent>,
    schema: Option<RbIdent>,
    name: RbIdent,
    alias: Option<RbIdent>,
}

impl TryConvert for RbTableReferenceInner {
    fn try_convert(val: Value) -> Result<Self, Error> {
        Ok(Self {
            catalog: val.funcall("catalog", ())?,
            schema: val.funcall("schema", ())?,
            name: val.funcall("name", ())?,
            alias: val.funcall("alias", ())?,
        })
    }
}

#[derive(Clone)]
#[magnus::wrap(class = "SqlInsight::TableReference")]
pub struct RbTableReference {
    inner: RefCell<RbTableReferenceInner>,
}

impl TryConvert for RbTableReference {
    fn try_convert(val: Value) -> Result<Self, Error> {
        Ok(Self {
            inner: RefCell::new(RbTableReferenceInner::try_convert(val)?),
        })
    }
}

unsafe impl TryConvertOwned for RbTableReference {}

unsafe impl IntoValueFromNative for RbTableReference {}

impl Default for RbTableReference {
    fn default() -> Self {
        Self {
            inner: RefCell::new(RbTableReferenceInner::default()),
        }
    }
}

impl RbTableReference {
    pub fn new(
        catalog: Option<&RbIdent>,
        schema: Option<&RbIdent>,
        name: &RbIdent,
        alias: Option<&RbIdent>,
    ) -> Self {
        Self {
            inner: RbTableReferenceInner {
                catalog: catalog.cloned(),
                schema: schema.cloned(),
                name: name.clone(),
                alias: alias.cloned(),
            }
            .into(),
        }
    }

    pub fn from_table_reference(table_reference: &TableReference) -> Result<Self, Error> {
        Ok(Self {
            inner: RefCell::new(RbTableReferenceInner {
                catalog: table_reference
                    .catalog
                    .clone()
                    .map(|ident| RbIdent::from_ident(&ident)),
                schema: table_reference
                    .schema
                    .clone()
                    .map(|ident| RbIdent::from_ident(&ident)),
                name: RbIdent::from_ident(&table_reference.name),
                alias: table_reference
                    .alias
                    .clone()
                    .map(|ident| RbIdent::from_ident(&ident)),
            }),
        })
    }

    fn catalog(&self) -> Option<RbIdent> {
        self.inner.borrow().catalog.clone()
    }

    fn set_catalog(&self, catalog: Option<&RbIdent>) {
        self.inner.borrow_mut().catalog = catalog.cloned();
    }

    fn schema(&self) -> Option<RbIdent> {
        self.inner.borrow().schema.clone()
    }

    fn set_schema(&self, schema: Option<&RbIdent>) {
        self.inner.borrow_mut().schema = schema.cloned();
    }

    fn name(&self) -> RbIdent {
        self.inner.borrow().name.clone()
    }

    fn set_name(&self, name: &RbIdent) {
        self.inner.borrow_mut().name = name.clone();
    }

    fn alias(&self) -> Option<RbIdent> {
        self.inner.borrow().alias.clone()
    }

    fn set_alias(&self, alias: Option<&RbIdent>) {
        self.inner.borrow_mut().alias = alias.cloned();
    }
}

pub fn init() -> Result<(), Error> {
    let class = root().define_class("TableReference", class::object())?;
    class.define_singleton_method("new", function!(RbTableReference::new, 4))?;
    class.define_method("catalog", method!(RbTableReference::catalog, 0))?;
    class.define_method("catalog=", method!(RbTableReference::set_catalog, 1))?;
    class.define_method("schema", method!(RbTableReference::schema, 0))?;
    class.define_method("schema=", method!(RbTableReference::set_schema, 1))?;
    class.define_method("name", method!(RbTableReference::name, 0))?;
    class.define_method("name=", method!(RbTableReference::set_name, 1))?;
    class.define_method("alias", method!(RbTableReference::alias, 0))?;
    class.define_method("alias=", method!(RbTableReference::set_alias, 1))?;
    Ok(())
}
