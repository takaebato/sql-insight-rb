use crate::ruby_api::root;
use crate::ruby_api::{RbCrudTables, RbTables};
use magnus::{exception, function, Error, Object, RArray};
use sql_insight::sqlparser::dialect;
use sql_insight::sqlparser::dialect::Dialect;
use sql_insight::NormalizerOptions;

fn get_dialect(dialect_name: &str) -> Result<Box<dyn Dialect>, sql_insight::error::Error> {
    dialect::dialect_from_str(dialect_name).ok_or_else(|| {
        sql_insight::error::Error::ArgumentError(format!("Dialect not found: {}", dialect_name))
    })
}

pub fn rb_format(dialect_name: String, sql: String) -> Result<Vec<String>, Error> {
    match sql_insight::format(
        get_dialect(dialect_name.as_str()).unwrap().as_ref(),
        sql.as_str(),
    ) {
        Ok(result) => Ok(result),
        Err(error) => Err(Error::new(exception::runtime_error(), error.to_string())),
    }
}

fn rb_normalize(dialect_name: String, sql: String) -> Result<Vec<String>, Error> {
    match sql_insight::normalize_with_options(
        get_dialect(dialect_name.as_str()).unwrap().as_ref(),
        sql.as_str(),
        NormalizerOptions::new(),
    ) {
        Ok(result) => Ok(result),
        Err(error) => Err(Error::new(exception::runtime_error(), error.to_string())),
    }
}

fn rb_extract_tables(dialect_name: String, sql: String) -> Result<RArray, Error> {
    match sql_insight::extract_tables(
        get_dialect(dialect_name.as_str()).unwrap().as_ref(),
        sql.as_str(),
    ) {
        Ok(result) => {
            let mut results_of_tables = vec![];
            for tables in result {
                match tables {
                    Ok(tables) => results_of_tables.push(RbTables::from_tables(&tables).unwrap()),
                    Err(_error) => (),
                }
            }
            Ok(RArray::from_vec(results_of_tables))
        }
        Err(error) => Err(Error::new(exception::runtime_error(), error.to_string())),
    }
}

fn rb_extract_crud_tables(dialect_name: String, sql: String) -> Result<RArray, Error> {
    match sql_insight::extract_crud_tables(
        get_dialect(dialect_name.as_str()).unwrap().as_ref(),
        sql.as_str(),
    ) {
        Ok(result) => {
            let mut results_of_crud_tables = vec![];
            for crud_tables in result {
                match crud_tables {
                    Ok(crud_tables) => results_of_crud_tables
                        .push(RbCrudTables::from_crud_tables(&crud_tables).unwrap()),
                    Err(_error) => (),
                }
            }
            Ok(RArray::from_vec(results_of_crud_tables))
        }
        Err(error) => Err(Error::new(exception::runtime_error(), error.to_string())),
    }
}

pub fn init() -> Result<(), Error> {
    root().define_singleton_method("format", function!(rb_format, 2))?;
    root().define_singleton_method("normalize", function!(rb_normalize, 2))?;
    root().define_singleton_method("extract_tables", function!(rb_extract_tables, 2))?;
    root().define_singleton_method("extract_crud_tables", function!(rb_extract_crud_tables, 2))?;
    Ok(())
}
