# Repository for vwfinley/texlive
Contains code to build a Docker developer container containing the TexLive distribution
of the LaTeX typesetting system.

The container is a developer container appropriate for use with VSCode,
however, it is not necessary to open the container in VSCode or remote into it.

## Get the container
Before using the container you'll first need to pull the container.

To pull the latest container version from the GitHub package repository
into your local docker repo, simply do the following at the commandline.
```
docker pull ghcr.io/vwfinley/texlive:latest

docker images
```

## Run the container 
In typical usage the container can be run externally from the Docker host
by calling the Docker run command from the current directory.

For example:
```
docker run --rm -it \
    -v $(pwd):/workspace \
    ghcr.io/vwfinley/texlive:latest \
    latex -output-format=pdf -output-directory=output input.tex
```

Be sure to use the `-v $(pwd):/workspace` option above, as this will map your files in 
the current directory to the /workspace directory inside the developer container.

The latex process is the actual process that converts your main input.tex LaTeX source file into the finished pdf file.
The `latex` reference above tells Docker to run the latex process on your input.tex file inside the container.

The completed pdf file will be written to the subdirectory given by `-output-directory=output`

## Extend the container (Errors and Missing packages)
The container does not have the full TexLive system installed, as that would be quite large.
So instead the container was built with the TexLive scheme=small option.

While the scheme=small option has most of what is needed for generating most documents, it will inevitably be missing some tlmgr packages.
Occasionally an error saying some .sty package file cannot be found.
```
! LaTeX Error: File `gensymb.sty' not found.
```
No worries, you can always add any missing packages.

The best way to add the packages is to create a Dockerfile.
Inside the Dockerfile run tlmgr to add the additional packages.
For example:
```
tlmgr install gensymb 
```

A better example is to see the Dockerfile at `https://github.com/vwfinley/texlive_dev`
