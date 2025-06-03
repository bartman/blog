.PHONY: all build pub publish srv serve server
all build:
	hugo

pub publish: build
	rsync -avz --delete public/ up.jukie.net:public_html/blog/

srv serve server: build
	hugo server --buildDrafts
