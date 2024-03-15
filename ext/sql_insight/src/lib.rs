mod errors;
mod ruby_api;

use magnus::Error;

#[magnus::init]
fn init() -> Result<(), Error> {
    ruby_api::init()
}
