# Architecture

## Goal
Deploy a lightweight WAF layer on AWS EC2 using the `owasp/modsecurity-crs` container.

## Components
- EC2 instance (Amazon Linux 2023)
- Docker + Docker Compose plugin
- WAF container: `owasp/modsecurity-crs:nginx`
- Backend application running on host or another container

## Traffic Flow
1. Client sends HTTP/HTTPS request to EC2 public endpoint.
2. Request reaches ModSecurity + CRS in NGINX container.
3. Allowed request is proxied to backend (`BACKEND` env variable).
4. Blocked request returns HTTP 403 with security log.

## Rule Strategy
- Use OWASP CRS defaults for broad coverage.
- Add project-specific exceptions/blocks in `config/modsecurity/custom-rules.conf`.
- Start with conservative paranoia level and raise gradually.
