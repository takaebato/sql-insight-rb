use crate::ruby_api::{root, RbTableReference};
use magnus::{class, function, method, Error, IntoValueFromNative, Module, Object, RArray};
use sql_insight::Tables;
use std::cell::RefCell;

#[derive(Default, Clone)]
struct RbTablesInner {
    tables: Vec<RbTableReference>,
}

impl RbTablesInner {
    pub fn new(tables: RArray) -> Result<Self, Error> {
        Ok(Self {
            tables: tables.to_vec::<RbTableReference>()?,
        })
    }
}

#[magnus::wrap(class = "SqlInsight::Tables")]
pub struct RbTables {
    inner: RefCell<RbTablesInner>,
}

unsafe impl IntoValueFromNative for RbTables {}

impl Default for RbTables {
    fn default() -> Self {
        Self {
            inner: RefCell::new(RbTablesInner::default()),
        }
    }
}

impl RbTables {
    pub fn new(tables: RArray) -> Result<Self, Error> {
        Ok(Self {
            inner: RefCell::new(RbTablesInner::new(tables)?),
        })
    }

    pub fn from_tables(tables: &Tables) -> RbTables {
        RbTables {
            inner: RefCell::new(RbTablesInner {
                tables: tables
                    .0
                    .iter()
                    .map(RbTableReference::from_table_reference)
                    .collect(),
            }),
        }
    }

    fn tables(&self) -> RArray {
        RArray::from_vec(self.inner.borrow().tables.clone())
    }

    fn set_tables(&self, tables: RArray) -> Result<(), Error> {
        self.inner.borrow_mut().tables = tables.to_vec::<RbTableReference>()?;
        Ok(())
    }
}

pub fn init() -> Result<(), Error> {
    let class = root().define_class("Tables", class::object())?;
    class.define_singleton_method("new", function!(RbTables::new, 1))?;
    class.define_method("tables", method!(RbTables::tables, 0))?;
    class.define_method("tables=", method!(RbTables::set_tables, 1))?;
    Ok(())
}
