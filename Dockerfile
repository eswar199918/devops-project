FROM python:3.9-slim

# -----------------------------
# Create non-root user
# -----------------------------
RUN useradd -m appuser

# -----------------------------
# Set working directory
# -----------------------------
WORKDIR /app

# -----------------------------
# Install dependencies first (cache optimization)
# -----------------------------
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# -----------------------------
# Copy application code
# -----------------------------
COPY . .

# -----------------------------
# Change ownership (security)
# -----------------------------
RUN chown -R appuser:appuser /app

# -----------------------------
# Switch to non-root user
# -----------------------------
USER appuser

# -----------------------------
# Expose port
# -----------------------------
EXPOSE 5000

# -----------------------------
# Run application
# -----------------------------
CMD ["python", "app.py"]
