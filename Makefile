name=openoffice-calc

config=${HOME}/.config/openoffice
data=${HOME}/containers/$(name)

.PHONY: image run

$(config):
	mkdir -p $(config)

$(data):
	mkdir -p $(data)

image: Dockerfile
	podman build -t $(name) .

run: $(config) $(data)
	podman run --rm -d \
		-e DISPLAY=unix${DISPLAY} \
		-v $(config)/:/root/.openoffice/:rw \
		-v $(data)/:/root/data/:rw \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /usr/share/X11/xkb/:/usr/share/X11/xkb/:ro \
		$(name)
