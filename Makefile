setup:
	if [ ! -d "pierluigi" ]; then git clone https://github.com/joao18araujo/pierluigi; fi
	cd pierluigi; \
	git pull origin master; \
	make; \
	cp bin/prog ../public/executable/counterpoint_generator; \
