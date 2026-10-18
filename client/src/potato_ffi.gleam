@external(javascript, "./potato_ffi_js.mjs", "get_text_content")
pub fn get_text_content(selector: String) -> Result(String, Nil)

@external(javascript, "./potato_ffi_js.mjs", "open_dialog")
pub fn open_dialog(id: String) -> Nil
