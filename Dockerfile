FROM ansible-tower:3.1.1

# TODO: add python libraries
ENV PYTHONNOUSERSITE True

ENV ANSIBLE_LIBRARY /opt/oneview-ansible/library

RUN . /var/lib/awx/venv/ansible/bin/activate &&\
	pip install git+https://github.com/HewlettPackard/python-hpOneView.git && \ 
	pip install hpICsp 

RUN git clone https://github.com/HewlettPackard/oneview-ansible.git /opt/oneview-ansible &&\
	cp -r /opt/oneview-ansible/library/module_utils /var/lib/awx/venv/ansible/lib/python2.7/site-packages/ &&\
	mkdir -p /usr/lib/python2.7/dist-packages/ansible/modules/dxc_custom_oneview-ansible &&\
	mv /opt/oneview-ansible/library/* /usr/lib/python2.7/dist-packages/ansible/modules/dxc_custom_oneview-ansible



#RUN git clone https://github.com/HewlettPackard/oneview-ansible.git /opt/oneview-ansible
#RUN echo $ANSIBLE_LIBRARY > /var/lib/awx/venv/ansible/local/lib/python2.7/site-packages/ansible_library.pth
RUN echo AWX_TASK_ENV[\'ANSIBLE_LIBRARY\']=\'$ANSIBLE_LIBRARY\' >> /etc/tower/settings.py
RUN echo ANSIBLE LIBRARY IS !!!! $ANSIBLE_LIBRARY 




COPY userstart /userstart
RUN chmod +x ./userstart

COPY creds.json /opt/