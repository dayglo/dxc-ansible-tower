FROM ansible-tower:3.1.1

# TODO: add python libraries
ENV PYTHONNOUSERSITE True

RUN git clone https://github.com/HewlettPackard/python-hpOneView.git /tmp/python-hpOneView &&\
	cd /tmp/python-hpOneView &&\
	. /var/lib/awx/venv/ansible/bin/activate &&\
	pip install . && \ 
	rm -rf /tmp/python-hpOneView 

COPY synergy-poc-setup /tmp/synergy-poc-setup

RUN /usr/bin/ansible-tower-service start &&\
	sleep 10 &&\
	apt install -y python-pip &&\
	pip install ansible-tower-cli &&\
	tower-cli config host localhost  &&\
	tower-cli config username admin  &&\
	tower-cli config password cloud5cloud!  &&\
	ansible-playbook -i "localhost," -c local /tmp/synergy-poc-setup/playbook.yml &&\
	/usr/bin/ansible-tower-service stop &&\
	echo done.

RUN /usr/bin/ansible-tower-service start &&\
	sleep 10 &&\
	tower-cli user create --username=guido --first-name=Guido \
                        --last-name="Van Rossum" --email=guido@python.org \
                        --password=password1234

RUN /usr/bin/ansible-tower-service start &&\
	sleep 5 &&\
	tower-cli project list &&\
	tower-cli team list &&\
	tower-cli user list
