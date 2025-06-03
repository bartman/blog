.PHONY: all build pub publish srv serve server
all build:
	hugo

pub publish: build
	cd public && test ! -e tag && ln -fs tags tag
	cd public && test ! -e blog && ln -fs . blog
	rsync -avz --delete public/ up.jukie.net:public_html/

srv serve server: build
	hugo server --buildDrafts
