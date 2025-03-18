# Base Image
FROM ruby:3.4.2

# Encoding
# C.UTF8 locale supports Computer English language
ENV LANG C.UTF-8

# Default user and group id. This is important to avoid permission errors.
#
# All Linux users have a user ID and a group ID and a unique numerical
# identification number called a userid (UID) and a groupid (GID) respectively.
# Groups can be assigned to logically tie users together for a common security,
# privilege and access purpose. It is the foundation of Linux security and
# access.
ARG USER_ID=1000
ARG GROUP_ID=1000

# -q, --quiet
#    Quiet. Produces output suitable for logging, omitting progress indicators.
#    More q's will produce more quiet up to a maximum of two. You can also use
#    -q=# to set the quiet level, overriding the configuration file. Note that
#    quiet level 2 implies -y, you should never use -qq without a no-action
#    modifier such as -d, --print-uris or -s as APT may decided to do something
#    you did not expect.
#
#    build-essential is a package which contains references to numerous
#    packages needed for building software in general, it contais g++, gcc,
#    make tool between others package
#
#    curl is used in command lines or scripts to transfer data
#
#    libpq-dev are header files and static library for compiling C programs to
#    link with the libpq library in order to communicate with a PostgreSQL
#    database backend.
#
#    libxml2-dev Development files for the GNOME XML library
#
#    libxslt1-dev XSLT is an XML language for defining transformations of XML
#    files from XML to some other arbitrary format, such as XML, HTML, plain
#    text, etc.
#
#    imagemagick is a free and open-source software suite for displaying,
#    creating, converting, modifying, and editing raster image.
#
#    git
#    Git is a distributed version-control system for tracking changes in
#    source code during software development.
#
#    procps
#    This package provides command line and full screen utilities for browsing
#    procfs, a "pseudo" file system dynamically generated by the kernel to
#    provide information about the status of entries in its process table
#    (such as whether the process is running, stopped, or a "zombie").
#    .
#    It contains free, kill, pkill, pgrep, pmap, ps, pwdx, skill, slabtop,
#    snice, sysctl, tload, top, uptime, vmstat, w, and watch.
#
#    cron
#    The cron command-line utility is a job scheduler on Unix-like operating
#    systems. Users who set up and maintain software environments use cron to
#    schedule jobs, also known as cron jobs, to run periodically at fixed
#    times, dates, or intervals.
#
#    sudo
#    sudo is a program for Unix-like computer operating systems that
#    allows users to run programs with the security privileges of another user,
#    by default the superuser.
#
#    vim
#    Vim is a free and open-source, screen-based text editor program. It is an
#    improved clone of Bill Joy's vi. Vim's author, Bram Moolenaar, derived Vim
#    from a port of the Stevie editor for Amiga and released a version to the
#    public in 1991.
RUN apt-get update -qq && \
  apt-get install -y curl \
  build-essential \
  libpq-dev    \
  libxml2-dev  \
  libxslt1-dev \
  imagemagick  \
  git          \
  rsync        \
  procps       \
  cron         \
  sudo         \
  vim

ENV _USER devel
ENV APP_NAME farma
ENV APP /var/www/${APP_NAME}
ENV BUNDLE_PATH /bundle/vendor

# ADD an user called devel
# --gecos GECOS
#          Set  the  gecos (information about the user) field for the new entry generated.  adduser will
#          not ask for finger information if this option is given
#
# The users of the group staff can install executables in /usr/local/bin and /usr/local/sbin without root privileges
RUN addgroup --gid $GROUP_ID ${_USER}
RUN adduser  --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID ${_USER} \
  && usermod -a -G sudo ${_USER} \
  && usermod -a -G staff ${_USER} \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && echo "${_USER}:${_USER}" | chpasswd

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT commands.
RUN mkdir -p $APP \
  && mkdir -p $BUNDLE_PATH

# Change current user
# USER ${_USER}:${_USER}

# Set working directory
WORKDIR $APP

# Install bundler and rails
RUN gem install bundler -v 2.6.6 \
  && gem install rails -v 7.1.3
