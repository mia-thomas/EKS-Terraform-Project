# Cluster & Node Creation using Terraform

# Task:

-   [ ] Create VPC
-   [ ] Create Private subnets
-  [ ] Implement required resources and routing to allow private subnet to have internet access, make it Highly Available (1 AZ going down shouldn’t affect the others traffic)
-   [ ] Create public subnets
-   [ ] Create EKS cluster in appropriate subnet (research public vs private)
-   [ ] Create necessary IAM roles for EKS control plane
-   [ ] Create necessary IAM roles for EKS nodes
-   [ ] Create an Auto Scaling Group that will create the worker nodes, make sure they connect to the cluster automatically on startup (node group)
    -   [ ] Create a ‘self managed node group’ which is an ASG but you need to configure everything yourself (like user data to bootstrap the node to the cluster etc.)
-   [ ] Setup kubectl access and run `kubectl get nodes` make sure you can see the nodes.