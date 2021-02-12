FROM ubuntu:latest AS downloader

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install curl

RUN curl -o office.tar.gz https://netactuate.dl.sourceforge.net/project/openofficeorg.mirror/4.1.9/binaries/en-US/Apache_OpenOffice_4.1.9_Linux_x86-64_install-deb_en-US.tar.gz


FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

COPY --from=downloader office.tar.gz office.tar.gz

RUN apt-get update \
	&& apt-get -y install default-jre \
	&& tar -xvzf office.tar.gz \
	&& rm office.tar.gz \
	&& cd en-US/DEBS \
	&& dpkg -i *.deb \
	&& cd / \
	&& rm -r en-US

ENTRYPOINT ["/opt/openoffice4/program/scalc"]
