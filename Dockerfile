FROM ansible-tower:3.1.1

# TODO: add python libraries
ENV PYTHONNOUSERSITE True

RUN git clone https://github.com/HewlettPackard/python-hpOneView.git /tmp/python-hpOneView &&\
	cd /tmp/python-hpOneView &&\
	. /var/lib/awx/venv/ansible/bin/activate &&\
	pip install . && \ 
	rm -rf /tmp/python-hpOneView 
