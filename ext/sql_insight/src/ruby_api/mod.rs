use magnus::value::Lazy;
use magnus::{Error, RModule, Ruby};

mod crud_tables;
mod ident;
mod pub_funcs;
mod table_reference;
mod tables;

pub use crud_tables::RbCrudTables;

pub use table_reference::RbTableReference;
pub use tables::RbTables;

pub fn root() -> RModule {
    static ROOT: Lazy<RModule> = Lazy::new(|ruby| ruby.define_module("SqlInsight").unwrap());
    let ruby = Ruby::get().unwrap();
    ruby.get_inner(&ROOT)
}

pub fn init() -> Result<(), Error> {
    ident::init()?;
    table_reference::init()?;
    tables::init()?;
    crud_tables::init()?;
    pub_funcs::init()?;

    Ok(())
}
