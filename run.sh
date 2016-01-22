#!/usr/bin/env bash
set -e

mkdir -p /output/swagger-1.2
javadoc \
-d /output/swagger-1.2 \
-doclet com.carma.swagger.doclet.ServiceDoclet \
-docletpath /swagger-doclet/swagger-doclet-1.1.1.jar \
-classpath $(find /dependencies -name "*.jar" -printf "%p:") \
$JAVADOC_ARGS \
$(find /sources -name "*.java" -printf "%p ")

echo "Converting from 1.2 to 2.0..."

mkdir -p /output/swagger-2.0
swagger-tools \
convert --no-validation \
/output/swagger-1.2/service.json \
$(find /output/swagger-1.2 -name "*.json" ! -name 'service.json' -printf "%p ") \
> /output/swagger-2.0/swagger.json

echo "Done."
