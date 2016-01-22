# swagger-generator-java
A docker application to generate swagger 2.0 json api description from java source files.

The JSR 311 (JAX-RS) and JSR 339 (JAX-RS 2.0) annotations, the model objects, enum values, as well as the javadoc are used to generate
the api descriptions.

- It uses the [swagger-jaxrs-doclet](https://github.com/teamcarma/swagger-jaxrs-doclet) to generate swagger 1.2 api descriptions
- It uses the [swagger-tools CLI](https://www.npmjs.com/package/swagger-tools) to convert 1.2 description to 2.0

# Usage
    docker run --rm \
    -u $(id -u):$(id -g) \
    -v <path/to/java/sources>:/sources \
    -v <path/to/java/dependencies>:/dependencies \
    -v <path/to/output>:/output \
    swagger-generator-java

- Sources is a directory containing your .java source files (they can be in sub-directories)
- Dependencies is a directory containing .jar files that need in the classpath when generating the javadoc for the .java files.
If you are using maven, it is typically the output in target/dependency after running "mvn dependency:copy-dependencies".
- Output will contain a swagger-1.2 and swagger-2.0 directories with respective api description formats.

# Configuration
You can override the JAVADOC_ARGS environment variable to customize the behavior of the swagger-jaxrs-doclet.
