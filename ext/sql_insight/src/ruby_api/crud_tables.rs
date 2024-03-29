use crate::ruby_api::{root, RbTableReference};
use magnus::{class, function, method, Error, IntoValueFromNative, Module, Object, RArray};
use sql_insight::CrudTables;
use std::cell::RefCell;

#[derive(Default, Clone)]
struct RbCrudTablesInner {
    create_tables: Vec<RbTableReference>,
    read_tables: Vec<RbTableReference>,
    update_tables: Vec<RbTableReference>,
    delete_tables: Vec<RbTableReference>,
}

impl RbCrudTablesInner {
    pub fn new(
        create_tables: RArray,
        read_tables: RArray,
        update_tables: RArray,
        delete_tables: RArray,
    ) -> Result<Self, Error> {
        Ok(Self {
            create_tables: create_tables.to_vec::<RbTableReference>()?,
            read_tables: read_tables.to_vec::<RbTableReference>()?,
            update_tables: update_tables.to_vec::<RbTableReference>()?,
            delete_tables: delete_tables.to_vec::<RbTableReference>()?,
        })
    }
}

#[magnus::wrap(class = "SqlInsight::CrudTables")]
pub struct RbCrudTables {
    inner: RefCell<RbCrudTablesInner>,
}

unsafe impl IntoValueFromNative for RbCrudTables {}

impl Default for RbCrudTables {
    fn default() -> Self {
        Self {
            inner: RefCell::new(RbCrudTablesInner::default()),
        }
    }
}

impl RbCrudTables {
    pub fn new(
        create_tables: RArray,
        read_tables: RArray,
        update_tables: RArray,
        delete_tables: RArray,
    ) -> Result<Self, Error> {
        Ok(Self {
            inner: RefCell::new(RbCrudTablesInner::new(
                create_tables,
                read_tables,
                update_tables,
                delete_tables,
            )?),
        })
    }

    pub fn from_crud_tables(crud_tables: &CrudTables) -> RbCrudTables {
        RbCrudTables {
            inner: RefCell::new(RbCrudTablesInner {
                create_tables: crud_tables
                    .create_tables
                    .iter()
                    .map(RbTableReference::from_table_reference)
                    .collect(),
                read_tables: crud_tables
                    .read_tables
                    .iter()
                    .map(RbTableReference::from_table_reference)
                    .collect(),
                update_tables: crud_tables
                    .update_tables
                    .iter()
                    .map(RbTableReference::from_table_reference)
                    .collect(),
                delete_tables: crud_tables
                    .delete_tables
                    .iter()
                    .map(RbTableReference::from_table_reference)
                    .collect(),
            }),
        }
    }

    fn create_tables(&self) -> RArray {
        RArray::from_vec(self.inner.borrow().create_tables.clone())
    }

    fn set_create_tables(&self, create_tables: RArray) -> Result<(), Error> {
        self.inner.borrow_mut().create_tables = create_tables.to_vec::<RbTableReference>()?;
        Ok(())
    }

    fn read_tables(&self) -> RArray {
        RArray::from_vec(self.inner.borrow().read_tables.clone())
    }

    fn set_read_tables(&self, read_tables: RArray) -> Result<(), Error> {
        self.inner.borrow_mut().read_tables = read_tables.to_vec::<RbTableReference>()?;
        Ok(())
    }

    fn update_tables(&self) -> RArray {
        RArray::from_vec(self.inner.borrow().update_tables.clone())
    }

    fn set_update_tables(&self, update_tables: RArray) -> Result<(), Error> {
        self.inner.borrow_mut().update_tables = update_tables.to_vec::<RbTableReference>()?;
        Ok(())
    }

    fn delete_tables(&self) -> RArray {
        RArray::from_vec(self.inner.borrow().delete_tables.clone())
    }

    fn set_delete_tables(&self, delete_tables: RArray) -> Result<(), Error> {
        self.inner.borrow_mut().delete_tables = delete_tables.to_vec::<RbTableReference>()?;
        Ok(())
    }
}

pub fn init() -> Result<(), Error> {
    let class = root().define_class("CrudTables", class::object())?;
    class.define_singleton_method("new", function!(RbCrudTables::new, 4))?;
    class.define_method("create_tables", method!(RbCrudTables::create_tables, 0))?;
    class.define_method(
        "create_tables=",
        method!(RbCrudTables::set_create_tables, 1),
    )?;
    class.define_method("read_tables", method!(RbCrudTables::read_tables, 0))?;
    class.define_method("read_tables=", method!(RbCrudTables::set_read_tables, 1))?;
    class.define_method("update_tables", method!(RbCrudTables::update_tables, 0))?;
    class.define_method(
        "update_tables=",
        method!(RbCrudTables::set_update_tables, 1),
    )?;
    class.define_method("delete_tables", method!(RbCrudTables::delete_tables, 0))?;
    class.define_method(
        "delete_tables=",
        method!(RbCrudTables::set_delete_tables, 1),
    )?;
    Ok(())
}
