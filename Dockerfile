# two phase build for production purposes, only copying necessities

# phase one: build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# phase two: run phase
FROM nginx
EXPOSE 80
# take from builder container and copy into nginx folder
COPY --from=builder /app/build /usr/share/nginx/html
