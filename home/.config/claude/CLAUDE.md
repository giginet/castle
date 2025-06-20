# Global Prompt for Claude

- Always respond in the same language as the question.

## Coding Guidelines for Swift

### Writing Tests

- Always write test with Swift Testing. Never use XCTest for new additions.
- Always drop `test` prefix for test names.
- Use `#expect(throws:)` to check the implementation throws an error.

### Misc API Usage

- Use these APIs to manipulate URLs:
    - URL(filePath:)
    - appending(component:) 
    - appending(components:)
- Do not use following legacy APIs:
    - URL(fileURLWithPath:)
    - appendingPathComponent(_:)
