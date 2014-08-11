all:
	pdflatex cv.tex

listen:
	while inotifywait -e close_write cv.tex; do sleep 1; make; done

clean:
	rm -f *.log *.aux *.pdf *.toc *.out *~

.PHONY: listen clean
