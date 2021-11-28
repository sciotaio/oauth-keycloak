This is a little sample project has been created as an introduction to OAuth (mostly 2.0) and its grants.

### Usage

* Run `docker-compose up -d``
* Explore keycloak at `${DOCKER_HOST}:15005`, `admin`/`password`
* Access jupyter at `${DOCKER_HOST}:15006`
* Prepare keycloak as described in notebook `initialize-keycloak.ipynb``
* Use the other notebooks to learn about the details of the OAuth 2.0 grants and about token verification

### Ideas for improvements

* Add photo storage/print scenario as classical OAuth 1.0 example
* Add PKCE to the slides



