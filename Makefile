all:
	hugo
	rsync -avz --delete public/ up.jukie.net:public_html/blog/

serve:
	hugo server --buildDrafts
