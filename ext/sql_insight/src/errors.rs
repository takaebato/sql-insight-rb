use crate::ruby_api::root;
use magnus::{
    exception::ExceptionClass, prelude::*, value::Lazy, Error, Ruby,
};

// define class `SqlInsight::Error < StandardError`
pub static ERROR: Lazy<ExceptionClass> = Lazy::new(|ruby| {
    root()
        .define_error("Error", ruby.exception_standard_error())
        .unwrap()
});

// define class `SqlInsight::ParserError < SqlInsight::Error`
pub static PARSER_ERROR: Lazy<ExceptionClass> = Lazy::new(|ruby| {
    root()
        .define_error("ParserError", ruby.get_inner(&ERROR))
        .unwrap()
});

// define class `SqlInsight::AnalysisError < SqlInsight::Error`
pub static ANALYSIS_ERROR: Lazy<ExceptionClass> = Lazy::new(|ruby| {
    root()
        .define_error("AnalysisError", ruby.get_inner(&ERROR))
        .unwrap()
});

pub fn convert_to_rb_error(ruby: &Ruby, error: sql_insight::error::Error) -> Error {
    match error {
        sql_insight::error::Error::ParserError(error) => {
            Error::new(ruby.get_inner(&PARSER_ERROR), error.to_string())
        }
        sql_insight::error::Error::AnalysisError(error) => {
            Error::new(ruby.get_inner(&ANALYSIS_ERROR), error.to_string())
        }
        _ => Error::new(ruby.get_inner(&ERROR), error.to_string()),
    }
}
