FROM fluent/fluentd:v1.0-debian-onbuild

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \
   && apt-get update \
   && apt-get install -y --no-install-recommends $buildDeps \
   && sudo gem install \
   fluent-plugin-secure-forward \
   && sudo gem install \
   fluent-plugin-elasticsearch \
   && sudo gem install \
   fluent-plugin-parser \
   && sudo gem install \
   fluent-plugin-ua-parser \
   && sudo gem install \
   fluent-plugin-concat \
   && sudo gem sources --clear-all \
   && SUDO_FORCE_REMOVE=yes \
   apt-get purge -y --auto-remove \
   -o APT::AutoRemove::RecommendsImportant=false \
   $buildDeps \
   && rm -rf /var/cache/apk/* \
   /home/fluent/.gem/ruby/2.3.0/cache/*.gem

EXPOSE 24284
EXPOSE 9880