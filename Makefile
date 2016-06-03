WWWDIR := $(DESTDIR)/var/www
LOCALPATH := env PATH=/usr/local/bin:$$PATH

build:
	$(LOCALPATH) sass --no-cache -I bases/page/css --update .
	$(LOCALPATH) coffee  -c  .

install:
	mkdir -p $(WWWDIR)
	cp -R bases $(WWWDIR)
	cp -R configs $(WWWDIR)
	cp -R etc $(WWWDIR)
	cp index.html $(WWWDIR)
	cp -R libs $(WWWDIR)
	cp -R models $(WWWDIR)
	cp -R modules $(WWWDIR)
	cp -R pages $(WWWDIR)
	cp -R tests $(WWWDIR)
	find $(WWWDIR) -name *.sass -exec rm {} \;
	find $(WWWDIR) -name *.coffee -exec rm {} \;
	find $(WWWDIR) -name *.map -exec rm {} \;
	chown -R www-data:www-data $(WWWDIR)/*
	chmod -R 775 $(WWWDIR)/*
