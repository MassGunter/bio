FROM ubuntu 
#определяем базовую операционную систему

RUN apt-get update && \ 
    apt-get install -y openjdk-11-jdk && \ 
    apt-get install -y python3-pip && \
    apt-get install -y curl && \ 
    apt-get install -y unzip && \
    apt-get install -y bedtools && \
    apt-get install -y wget && \ 
    apt-get install -y lastz



RUN pip install nextflow

COPY TOGA toga

# OR

# RUN git clone https://github.com/hillerlab/TOGA.git && \
#     cd CESAR2.0 && \
#     git clone https://github.com/kirilenkobm/CESAR2.0.git && \\ 
#     cd .. && \
#     cd postoga && \
#     git clone https://github.com/alejandrogzi/postoga.git



RUN cd toga && \
    python3 -m pip install -r requirements.txt --user && \
    ./configure.sh && \
    ./run_test.sh micro

COPY make_lastz_chains make_lastz_chains

# RUN cd .. &&\
#     git clone https://github.com/hillerlab/make_lastz_chains.git \
#     cd make_lastz_chains && \
#     pip3 install -r requirements.txt && \
#     ./install_dependencies.py


RUN cd .. && \
    cd make_lastz_chains && \
    pip3 install -r requirements.txt && \
    ./install_dependencies.py


RUN cd && \
    cd make_lastz_chains && \
    ./make_chains.py target query test_data/test_reference.fa test_data/test_query.fa --pd test_out -f --chaining_memory 16
# ./root/.nextflow/capsule/deps/io/nextflow


# Привет! Попробуй пару геномов замаскировать через RepeatMasker. 
# Делай hard маскирование, когда повторы на N заменяются. 
# Если это получится на компе сделать, можно попробовать дальше такие замаскированные выровнять. 
# Если все ок -- прекрасно. 
# Если нет, подумаем где считать. Хотя может уже и кусок сервера Миша найдет или мы что-то придумаем



# RUN curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029215505.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029215505.1.zip" -H "Accept: application/zip" 

# RUN 




# RUN nextflow run hello

# ENTRYPOINT ["curl -fsSL https://get.nextflow.io"]

# Укажите рабочий каталог
# WORKDIR /app

# Скопируйте ваш код и файлы проекта в контейнер
# COPY . .

# Укажите команду для запуска вашего приложения (например, вашей главной программы TOGA)
# CMD [ "python", "hello_world.py" ]


# docker run -it bio/toga
# docker run --mount type=bind, source=/data/mysql,target=/var/lib/mysql -it bio/toga




