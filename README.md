
# Expense Tracker Lite

A simple Phoenix LiveView application for tracking expenses. Features include:
- User login with a unique username (stored in memory)
- Real-time expense tracking with in-memory data storage
- Input validation and user-friendly forms using LiveView
- Modern UI styling with Tailwind CSS

## Table of Contents

- [Requirements](#requirements)
- [Setup Instructions](#setup-instructions)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Project Structure](#project-structure)
- [Additional Notes](#additional-notes)
- [Contributing](#contributing)
- [License](#license)

## Requirements

Make sure you have the following installed:

- **Elixir** 1.14 or higher
- **Erlang/OTP** 25 or higher
- **Node.js** 18 or higher (for asset compilation)

> **Note**: This version uses in-memory storage, so a database is not required.

## Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/cdvx/expense_tracker.git
   cd expense_tracker
   ```

2. **Install Elixir dependencies:**
   ```bash
   mix deps.get
   ```

3. **Install JavaScript dependencies:**
   ```bash
   npm install --prefix assets
   ```

4. **Compile the assets:**
   ```bash
   npm run deploy --prefix assets
   mix phx.digest
   ```

5. **Start the Phoenix server:**
   ```bash
   mix phx.server
   ```

6. Open the app in your browser at [http://localhost:4000](http://localhost:4000).

## Running the Application

To start the server locally:

```bash
mix phx.server
```

- The app will be available at [http://localhost:4000](http://localhost:4000).
- Log in with any unique username to start tracking your expenses.

> **Note**: The data is stored in memory and will be lost if the server restarts.

## Testing

To run the test suite:

```bash
mix test
```

Ensure all tests pass before pushing any changes.

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
- **`lib/expense_tracker_web/live/expense_live.html.heex`**: Template for the expense tracker UI.
- **`lib/expense_tracker_web/live/login_live.html.heex`**: Template for the login UI.
- **`lib/expense_tracker_web/templates/layout/app.html.heex`**: Main layout template.

## Additional Notes

- **Development Tips:**
  - Use `iex -S mix phx.server` to run the app with an interactive shell:
    ```bash
    iex -S mix phx.server
    ```
  - Live-reloading is enabled by default, so you can edit files and see changes without restarting the server.

- **In-Memory Storage:**
  - The current implementation uses in-memory storage for simplicity. All user data is lost upon server restart.
  - Consider integrating a database (e.g., PostgreSQL) with Ecto for persistent storage in a production environment.

- **Styling with Tailwind CSS:**
  - The UI is styled using Tailwind CSS. Customize the styles in `assets/css/app.css` and update configurations in `tailwind.config.js`.

## Contributing

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-branch
   ```
3. Make your changes and commit:
   ```bash
   git commit -m "Add new feature"
   ```
4. Push your changes:
   ```bash
   git push origin feature-branch
   ```
5. Open a Pull Request.

## License

This project is licensed under the [MIT License](LICENSE).
