FROM debian:12-slim

RUN apt-get update && apt-get install -y \
    bash git build-essential autoconf automake libncurses-dev libjansson-dev libcap-dev pkg-config locales

RUN mkdir -p /mtr
RUN useradd -m user
RUN chown user /mtr

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# add if you want sudo
#RUN apt-get install -y sudo
#RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/user

USER user
WORKDIR /mtr

RUN git clone https://github.com/traviscross/mtr.git /mtr
RUN ./bootstrap.sh
RUN ./configure
RUN make

CMD ["/bin/bash"]
