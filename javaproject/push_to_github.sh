#!/usr/bin/env bash
# ==========================================================
# CineBook - Automated Git Push Script
# Target: https://github.com/vishwassaini6839-ui/javaproject
# ==========================================================

set -e

REPO_URL="https://github.com/vishwassaini6839-ui/javaproject.git"

echo "==> Initializing Git Repository..."
if [ ! -d ".git" ]; then
    git init
fi

echo "==> Setting Default Branch to main..."
git branch -M main || true

echo "==> Configuring Remote Origin..."
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

echo "==> Staging all project files..."
git add .

echo "==> Committing changes..."
git commit -m "Initial commit: CineBook - Movie Ticket Booking System (Advanced Java JSP, Servlets, JDBC, MySQL, Tomcat 11)" || echo "Nothing new to commit."

echo "==> Pushing to GitHub (origin main)..."
git push -u origin main

echo "=========================================================="
echo "Successfully pushed to https://github.com/vishwassaini6839-ui/javaproject"
echo "=========================================================="
