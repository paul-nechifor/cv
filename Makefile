all:
	npm run generate
	pdflatex --shell-escape cv.tex

listen:
	while inotifywait -e close_write cv.tex; do sleep 1; make; done

clean:
	rm -f *.log *.aux *.pdf *.pdf_tex *.toc *.out *~

.PHONY: listen clean
