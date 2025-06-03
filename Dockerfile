FROM python:3.9-slim

# install dependencies of interest
RUN pip install --upgrade pip && \
    python -m pip install rasa && \
    python -m pip install transformers
# set workdir and copy data files from disk
# note the latter command uses .dockerignore !!
WORKDIR /app
ENV HOME=/app
COPY ./rasa_config .
# train a new rasa model!!!
RUN rasa train
# set the user to run, don't run as root
USER 1001
# set entrypoint for interactive shells
ENTRYPOINT ["rasa"]
# command to run when container is called to run
CMD ["run", "--enable-api", "--cors", "*", "--debug"]