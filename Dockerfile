# ============================================================
# DevOps Professional Resume Website
# Dockerfile
# ============================================================

# Use a lightweight, production-ready Nginx image
FROM nginx:alpine

# ------------------------------------------------------------
# Maintainer / Metadata
# ------------------------------------------------------------

LABEL maintainer="Ghislain Kameni"
LABEL description="Professional DevOps Engineer Resume Website"
LABEL version="1.0"

# ------------------------------------------------------------
# Remove Nginx default website
# ------------------------------------------------------------

RUN rm -rf /usr/share/nginx/html/*

# ------------------------------------------------------------
# Copy website files
# ------------------------------------------------------------

COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# ------------------------------------------------------------
# Expose HTTP port
# ------------------------------------------------------------

EXPOSE 80

# ------------------------------------------------------------
# Health check
# ------------------------------------------------------------

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=5s \
            --retries=3 \
            CMD wget --no-verbose --tries=1 \
                 --spider http://127.0.0.1/ || exit 1

# ------------------------------------------------------------
# Start Nginx
# ------------------------------------------------------------

CMD ["nginx", "-g", "daemon off;"]