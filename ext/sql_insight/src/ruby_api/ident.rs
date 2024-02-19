use crate::ruby_api::root;
use magnus::value::ReprValue;
use magnus::{class, function, method, Error, Module, Object, TryConvert};
use sql_insight::sqlparser::ast::Ident;
use std::cell::RefCell;

#[derive(Clone)]
#[magnus::wrap(class = "SqlInsight::Ident")]
pub struct RbIdent {
    pub inner: RefCell<Ident>,
}

impl TryConvert for RbIdent {
    fn try_convert(val: magnus::Value) -> Result<Self, Error> {
        Ok(Self {
            inner: RefCell::new(Ident {
                value: val.funcall("value", ())?,
                quote_style: val.funcall("quote_style", ())?,
            }),
        })
    }
}

impl Default for RbIdent {
    fn default() -> Self {
        Self {
            inner: RefCell::new(Ident::new(String::new())),
        }
    }
}

impl RbIdent {
    pub fn new(value: String, quote: Option<char>) -> Self {
        Self {
            inner: RefCell::new(Ident {
                value,
                quote_style: quote,
            }),
        }
    }

    pub fn from_ident(ident: &Ident) -> Self {
        Self {
            inner: RefCell::new(ident.clone()),
        }
    }

    fn value(&self) -> String {
        self.inner.borrow().value.clone()
    }

    fn set_value(&self, value: String) {
        self.inner.borrow_mut().value = value;
    }

    fn quote_style(&self) -> Option<char> {
        self.inner.borrow().quote_style
    }

    fn set_quote_style(&self, quote_style: Option<char>) {
        self.inner.borrow_mut().quote_style = quote_style;
    }
}

pub fn init() -> Result<(), Error> {
    let class = root().define_class("Ident", class::object())?;
    class.define_singleton_method("new", function!(RbIdent::new, 2))?;
    class.define_method("value", method!(RbIdent::value, 0))?;
    class.define_method("value=", method!(RbIdent::set_value, 1))?;
    class.define_method("quote_style", method!(RbIdent::quote_style, 0))?;
    class.define_method("quote_style=", method!(RbIdent::set_quote_style, 1))?;
    Ok(())
}
