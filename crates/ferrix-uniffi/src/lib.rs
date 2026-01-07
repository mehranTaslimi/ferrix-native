uniffi::setup_scaffolding!();

#[uniffi::export]
fn add(a: i32, b: i32) -> i32 {
    a + b
}
