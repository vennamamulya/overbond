# Install tools required for project
# Run `docker build --no-cache .` to update dependencies
RUN apk add --no-cache git
RUN go get https://github.com/vennamamulya/overbond

COPY app.py ip.txt /go/src/project/
WORKDIR /go/src/project/
# Install library dependencies
RUN dep ensure -vendor-only

COPY . /go/src/project/
RUN go build -o /bin/project

# This results in a single layer image
FROM scratch
COPY --from=build /bin/project /bin/project

ENTRYPOINT [&quot;/bin/project&quot;]
CMD [&quot;--help&quot;]
