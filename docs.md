
# Expense Tracker Lite: Application Documentation

## Overview

The **Expense Tracker Lite** is a Phoenix LiveView application designed to track user expenses with real-time updates. 
It leverages the power of Phoenix LiveView for interactive UI updates and uses an in-memory storage solution with a `GenServer` 
for simplicity. The goal of this project is to demonstrate real-time capabilities and state management in Elixir without the 
complexity of a database setup.

### Key Features

- **User Login:** Users can log in with a unique username, stored in memory.
- **Expense Tracking:** Users can add and view their expenses in real-time.
- **In-memory Data Storage:** Data is stored in a `GenServer` state, providing quick access and updates.
- **Real-time UI Updates:** The application uses Phoenix PubSub for broadcasting changes, providing a responsive experience.
- **Styling with Tailwind CSS:** The UI is styled with Tailwind CSS for a modern, responsive appearance.

## Architecture and Design Decisions

### 1. Phoenix LiveView for Real-time UI

The application uses Phoenix LiveView to provide a reactive user interface. This eliminates the need for complex 
JavaScript frameworks and allows for server-rendered updates. LiveView handles form submissions, input validation, 
and real-time updates, simplifying the front-end development process.

**Trade-offs:**
- **Pros:** Simplifies the front-end codebase, leverages server-side rendering, and integrates well with Elixir.
- **Cons:** Increased server load since the server must maintain a WebSocket connection for each connected client.

### 2. In-memory Storage with GenServer

The application stores user data (usernames and expenses) in memory using a `GenServer`. This design choice was made 
to avoid the complexity of setting up a database and to provide fast read/write access.

**Trade-offs:**
- **Pros:** Simple, fast, and easy to implement. Ideal for a demo or lightweight application.
- **Cons:** Data is not persistent and will be lost when the server restarts. The solution does not scale well with many users.

### 3. Real-time Updates with Phoenix PubSub

To keep the UI in sync with the server state, the application uses Phoenix PubSub to broadcast updates whenever a user's 
expenses are modified. This allows the client to receive real-time updates without polling the server.

**Trade-offs:**
- **Pros:** Efficient real-time updates without the need for additional client-side code.
- **Cons:** PubSub requires a WebSocket connection, which may become a bottleneck with a large number of users.

### 4. User Input Validation

The application validates user input both on the client-side (using HTML input types and attributes) and on the server-side 
(using LiveView event handlers and the `GenServer` state). This helps ensure data integrity.

**Trade-offs:**
- **Pros:** Provides a good user experience with instant feedback on input errors.
- **Cons:** Relying on client-side validation alone could lead to issues; server-side validation is necessary but increases complexity.

### 5. UI and Styling with Tailwind CSS

The application uses Tailwind CSS for styling. Tailwind's utility-first approach allows for rapid styling without 
writing custom CSS, resulting in a responsive and modern UI.

**Trade-offs:**
- **Pros:** Fast and efficient styling, responsive design out-of-the-box.
- **Cons:** The utility-first approach can lead to verbose HTML, and customization may require additional configuration.

## Project Structure

The application follows the standard Phoenix LiveView structure:

```
├── assets/             # Frontend assets (CSS, JS)
├── config/             # Configuration files
├── lib/
│   ├── expense_tracker/       # Core application logic
│   └── expense_tracker_web/   # Web interface (LiveViews, controllers, views)
│       ├── components/        # LiveView components
│       ├── controllers/       # Phoenix controllers
│       ├── layouts/           # Layout templates
│       └── live/              # LiveView modules and templates
├── priv/               # Static assets, migrations, and seeds
└── test/               # Test files
```

### Key Files

- **`lib/expense_tracker_web/live/expense_live.ex`**: Main LiveView module for the expense tracker.
- **`lib/expense_tracker_web/live/login_live.ex`**: LiveView module for user login.
- **`lib/expense_tracker/store.ex`**: `GenServer` module handling in-memory data storage.
- **`lib/expense_tracker_web/live/expense_live.html.heex`**: Template for the expense tracker UI.
- **`lib/expense_tracker_web/live/login_live.html.heex`**: Template for the login UI.

## Design Trade-offs

- **In-memory Storage vs. Persistence:** In-memory storage was chosen for simplicity. In a production environment, 
  a database like PostgreSQL with Ecto would be more appropriate to provide data persistence.
- **LiveView vs. Client-side Frameworks:** LiveView reduces the need for client-side JavaScript frameworks, 
  but it increases server load due to persistent WebSocket connections.
- **Scalability:** The current architecture may not scale well with high traffic or many concurrent users. 
  Scaling would require distributing state across nodes and using a persistent storage solution.

## How It Works

1. The user logs in with a unique username, which is validated and stored in the `GenServer` state.
2. The user can add expenses, which are stored in-memory and associated with their username.
3. When an expense is added, a PubSub message is broadcast to update the UI in real-time.
4. The expenses are displayed in a list, updating automatically as new expenses are added.

## Limitations

- The application does not persist data. All user data is lost if the server restarts.
- The current in-memory storage may lead to high memory usage if many users add a large number of expenses.
- The application is not designed for production use. It is intended for demonstration and learning purposes.

## Conclusion

The **Expense Tracker Lite** application showcases the capabilities of Phoenix LiveView and Elixir's concurrency model 
with `GenServer`. It provides a simple, interactive user experience with real-time updates but sacrifices scalability 
and data persistence. For production, consider using a persistent database, implementing session management, 
and distributing state across multiple nodes.

## License

This project is licensed under the [MIT License](LICENSE).
