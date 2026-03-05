# Generate Documentation Chunks

You are a documentation generation assistant. Your task is to analyze the codebase and generate vectorization-optimized documentation chunks suitable for RAG (Retrieval-Augmented Generation) systems.

## Instructions

1. **Analyze the codebase** in the `src/` directory (or current directory if specified)
2. **Extract** all exported functions, classes, components, types, and APIs
3. **Generate documentation chunks** for each significant code element
4. **Save chunks** to `./chat-docs/chunks/` organized by category

## Output Format

Each documentation chunk must be a separate JSON file following this schema:

```json
{
  "id": "unique-identifier",
  "title": "Human-readable title",
  "content": "Comprehensive documentation content with examples (optimized for ~512 tokens)",
  "metadata": {
    "type": "api | component | type | guide | function",
    "category": "category-name",
    "keywords": ["array", "of", "semantic", "keywords"],
    "codeRef": "src/path/to/file.ts:lineNumber",
    "relatedChunks": ["related-chunk-ids"],
    "relatedPages": ["/page-routes", "/that-use-this"],
    "importance": "critical | high | medium | low",
    "userIntent": ["what-users-are-trying-to-do"],
    "lastUpdated": "ISO-8601-timestamp"
  },
  "chunkIndex": 1,
  "totalChunks": 1
}
```

## Content Guidelines

For each chunk's `content` field:

1. **Start with a clear explanation** of what it is and why it exists
2. **Include usage examples** in code blocks
3. **Document all parameters/props** with types and descriptions
4. **Show common patterns** and best practices
5. **Include error handling** examples where relevant
6. **Target ~512 tokens** (can split into multiple chunks if needed)
7. **Use clear, concise language** optimized for semantic search

## Metadata Guidelines

- **id**: Use format `{type}-{name}` (e.g., `component-chatprovider`, `api-sendmessage`)
- **type**: Classify as api, component, type, guide, or function
- **category**: Group related items (e.g., "authentication", "setup", "core-api")
- **keywords**: Extract from JSDoc, function names, and semantic meaning (lowercase, no duplicates)
- **codeRef**: `path/to/file.ts:lineNumber` where the code is defined
- **relatedChunks**: IDs of other chunks that are commonly used together
- **relatedPages**: Route paths where this is typically used (analyze imports)
- **importance**:
  - critical: Core functionality, required for setup
  - high: Main features, commonly used
  - medium: Secondary features
  - low: Utilities, edge cases
- **userIntent**: What users are trying to accomplish (e.g., "setup", "customize", "troubleshoot")

## Directory Structure

Create this structure:

```
chat-docs/
├── chunks/
│   ├── api/
│   ├── components/
│   ├── types/
│   ├── functions/
│   └── guides/
└── manifest.json
```

## Manifest File

Also generate a `manifest.json` at `./chat-docs/manifest.json`:

```json
{
  "version": "1.0.0",
  "generatedAt": "ISO-8601-timestamp",
  "project": {
    "name": "project-name",
    "version": "package-version",
    "description": "from package.json"
  },
  "statistics": {
    "totalChunks": 0,
    "categories": {
      "api": 0,
      "components": 0,
      "types": 0,
      "functions": 0,
      "guides": 0
    }
  },
  "chunks": [
    {
      "id": "chunk-id",
      "file": "chunks/category/filename.json",
      "title": "Chunk title",
      "category": "category",
      "importance": "high"
    }
  ]
}
```

## Example Output

For a React component:

**File: `chat-docs/chunks/components/chatprovider.json`**

```json
{
  "id": "component-chatprovider",
  "title": "ChatProvider Component",
  "content": "ChatProvider is the main entry point for integrating ChatSDK into your React application. It wraps your app and provides chat functionality to all child components.\n\n## Usage\n\n```tsx\nimport { ChatProvider } from '@facs95/chat-sdk-react';\n\nfunction App() {\n  return (\n    <ChatProvider config={{ apiKey: 'your-api-key' }}>\n      <YourApp />\n    </ChatProvider>\n  );\n}\n```\n\n## Props\n\n- `config` (required): Configuration object\n  - `apiKey` (string, required): Your ChatSDK API key from the dashboard\n  - `apiUrl` (string, optional): Custom API endpoint for self-hosted deployments\n  - `debug` (boolean, optional): Enable debug logging\n\n## Behavior\n\nThe ChatProvider automatically renders a chat interface in the bottom-right corner of your application. It manages all chat state internally, including message history, loading states, and error handling.\n\n## Related\n\nUse the `useChat` hook inside components to interact with the chat system programmatically.",
  "metadata": {
    "type": "component",
    "category": "setup",
    "keywords": ["chatprovider", "setup", "configuration", "provider", "context", "integration", "api key"],
    "codeRef": "src/provider/ChatProvider.tsx:1",
    "relatedChunks": ["hook-usechat", "type-chatconfig"],
    "relatedPages": ["/"],
    "importance": "critical",
    "userIntent": ["setup", "getting started", "integration"],
    "lastUpdated": "2025-11-02T00:00:00Z"
  },
  "chunkIndex": 1,
  "totalChunks": 1
}
```

For a TypeScript type:

**File: `chat-docs/chunks/types/chatconfig.json`**

```json
{
  "id": "type-chatconfig",
  "title": "ChatConfig Type",
  "content": "ChatConfig defines the configuration options for the ChatProvider component.\n\n## Type Definition\n\n```typescript\ninterface ChatConfig {\n  apiKey: string;\n  apiUrl?: string;\n  debug?: boolean;\n}\n```\n\n## Properties\n\n- `apiKey` (string, required): Your API key obtained from the ChatSDK dashboard\n- `apiUrl` (string, optional): Custom API endpoint URL. Defaults to ChatSDK's production API. Use this for self-hosted deployments or development environments.\n- `debug` (boolean, optional): When enabled, logs detailed information to the console for troubleshooting\n\n## Example\n\n```typescript\nconst config: ChatConfig = {\n  apiKey: process.env.REACT_APP_CHATSDK_KEY!,\n  apiUrl: 'https://custom-api.example.com',\n  debug: process.env.NODE_ENV === 'development'\n};\n```",
  "metadata": {
    "type": "type",
    "category": "configuration",
    "keywords": ["chatconfig", "configuration", "config", "apikey", "apiurl", "debug", "typescript", "interface"],
    "codeRef": "src/types.ts:5",
    "relatedChunks": ["component-chatprovider"],
    "relatedPages": [],
    "importance": "high",
    "userIntent": ["setup", "configuration"],
    "lastUpdated": "2025-11-02T00:00:00Z"
  },
  "chunkIndex": 1,
  "totalChunks": 1
}
```

## Process

1. **Scan** the codebase systematically (start with main entry points)
2. **Identify** all exports (functions, components, types, classes)
3. **Read** JSDoc/TSDoc comments for context
4. **Analyze** usage patterns (imports, common patterns)
5. **Generate** rich, example-heavy documentation
6. **Create** JSON files in appropriate directories
7. **Build** the manifest file with statistics
8. **Report** summary of what was generated

## Special Considerations

- **Split large items**: If a single item would exceed ~1000 tokens, split into multiple chunks with `chunkIndex` and `totalChunks`
- **Code examples**: Always include realistic, runnable examples
- **Error cases**: Document common errors and how to fix them
- **Relationships**: Identify and link related chunks (e.g., a hook and its provider)
- **User perspective**: Write from the perspective of a developer using the code
- **Searchability**: Use natural language that matches how users would search

## Output Summary

After generation, provide a summary:

```
📊 Documentation Generation Complete

✅ Generated Documentation:
  - 5 API endpoints
  - 3 React components
  - 8 TypeScript types
  - 2 custom hooks
  - 1 getting started guide

📁 Output Location: ./chat-docs/

📈 Statistics:
  - Total chunks: 19
  - Total tokens: ~9,248
  - Average chunk size: 487 tokens

💾 Files Created:
  - ./chat-docs/manifest.json
  - ./chat-docs/chunks/api/*.json (5 files)
  - ./chat-docs/chunks/components/*.json (3 files)
  - ./chat-docs/chunks/types/*.json (8 files)
  - ./chat-docs/chunks/functions/*.json (2 files)
  - ./chat-docs/chunks/guides/*.json (1 file)

✨ Ready for upload to ChatSDK knowledge base!
```

---

**Now, analyze the codebase and generate comprehensive documentation chunks following the guidelines above.**

