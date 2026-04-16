FROM node:25-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN python3 -m pip install --break-system-packages feedgen pyyaml

# Install MyST Markdown
RUN npm install -g mystmd

WORKDIR /app
COPY . .

# Build site content
RUN myst build --site

# Generate RSS/Atom feeds (into repo root; copied later if HTML build exists)
RUN python3 generate_rss.py || true

EXPOSE 3000 3100

# Bind to 0.0.0.0 so the site is accessible outside the container
ENV HOST=0.0.0.0
CMD ["myst", "start", "--keep-host"]
