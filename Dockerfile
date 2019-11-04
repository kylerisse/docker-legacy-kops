FROM alpine

ENV KOPS_VERSION=1.10.0 \
    KUBECTL_VERSION=1.7.2 \
    KOPS_STATE_STORE=s3://my-kops \
    CLUSTER=k8s.example.com

RUN apk --update add bash ca-certificates python unzip vim wget

RUN wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip && \
    unzip awscli-bundle.zip && \
    chmod +x ./awscli-bundle/install && \
    ./awscli-bundle/install -i /usr/aws -b /usr/bin/aws

RUN mkdir -p /root/aws/
COPY config /root/.aws/
COPY credentials /root/.aws/

RUN wget https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 && \
    chmod +x kops-linux-amd64 && \
    mv kops-linux-amd64 /usr/bin/kops

RUN kops export kubecfg ${CLUSTER}

RUN wget https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/bin/
