uniffi::setup_scaffolding!();

#[uniffi::export]
fn hello() -> String {
    "HELLO WORLD".to_string()
}
