# rack-security-middleware
Middleware collection to secure a rack appplication

## Block Path Traversal
This middleware will block any request to a path containing `..` in it.
Those paths are technically valid (see [RFC3986](https://tools.ietf.org/html/rfc3986)) but are not necessary for all web applications.
