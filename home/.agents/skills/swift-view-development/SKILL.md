---
name: swift-view-development
description: Build iOS views in Swift using an agentic loop with Xcode Previews. Use when the user asks to create a view, implement a screen/UI, build a SwiftUI view, or any Swift view implementation task.
allowed-tools: mcp__xcode__RenderPreview
---

# Swift View Development with Xcode Previews

Build iOS views iteratively by implementing, previewing, and refining through an agentic loop.

## Agentic Loop Workflow

Repeat the following 3 steps until the view meets requirements.

### Step 1: Implement the View

Design the view with **injectable state** so it can be easily previewed with various configurations.

- Accept all data through properties or initializer parameters — never fetch data internally
- Abstract dependencies behind protocols or value types for easy preview substitution

```swift
// Good: Injectable state
struct UserProfileView: View {
    let userName: String
    let avatarURL: URL?
    let isOnline: Bool

    var body: some View { ... }
}

// Bad: Internal data fetching
struct UserProfileView: View {
    @State private var user: User?

    var body: some View {
        // fetches from API in onAppear...
    }
}
```

When using a ViewModel, define a protocol to keep it injectable:

```swift
@MainActor
protocol UserProfileViewModelProtocol: ObservableObject {
    var userName: String { get }
    var isLoading: Bool { get }
}

struct UserProfileView<ViewModel: UserProfileViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    var body: some View { ... }
}
```

### Step 2: Create Xcode Previews

Add previews covering the key display variations:

- Default / happy path (with data)
- Empty state (no data / empty list)
- Error state
- Loading state
- Boundary cases (long text, large datasets)
- Dark mode / Light mode
- Different Dynamic Type sizes

```swift
#Preview("Default") {
    UserProfileView(
        userName: "giginet",
        avatarURL: URL(string: "https://example.com/avatar.png"),
        isOnline: true
    )
}

#Preview("Offline") {
    UserProfileView(
        userName: "giginet",
        avatarURL: nil,
        isOnline: false
    )
}

#Preview("Long Name") {
    UserProfileView(
        userName: "A Very Long User Name That Might Overflow",
        avatarURL: nil,
        isOnline: true
    )
}
```

### Step 3: Render and Verify Previews

Use the `mcp__xcode__RenderPreview` tool to render each preview and visually inspect the result.

Check for:

- Layout matches the intent
- Text is not clipped or truncated
- Spacing and alignment are correct
- Colors and fonts are appropriate
- No visual breakage across variations

If any issue is found, **go back to Step 1**, fix the implementation, and re-render. Repeat until all previews look correct.

## Important Rules

- Render **all** preview variations, not just the default
- After every code change, **always re-render** to verify the fix
- If the user provided specific design requirements, verify compliance against them
