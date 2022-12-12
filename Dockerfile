FROM postgres:latest
# ARG FILE
# ARG DBNAME
# ENV FILE ${FILE}
# ENV DBNAME ${POSTGRES_USER}
WORKDIR /tmp

COPY ./restore_database.sh ./restore_database.sh
COPY ${PATH_RESTORE_FILE}${RESTORE_FILE} ./${RESTORE_FILE}
COPY ${PATH_DLL_FILE}${DLL_FILE} ./${DLL_FILE}

COPY restore_database.sh /docker-entrypoint-initdb.d/restore_database.sh
RUN sed -i 's/\r$//g' /docker-entrypoint-initdb.d/restore_database.sh
RUN chmod 777 /docker-entrypoint-initdb.d/restore_database.sh

EXPOSE 5432