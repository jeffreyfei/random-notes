# EBS-backed AMI

* Contains all information to boot an Amazon EC2 instance
  * A template for a computer's root volume
  * e.g. Linux, Apache, etc.
* Basic unit of deployment
* EBS-backed means that the root device of the AMI launched is an EBS volume created from an EBS snapshot
* It can also be backed by an instance store, which means the root device is an instance store volume created from a template stored in Amazon Simple Storage Device \(S3\)

### Creation

1. Navigate to the instance page and select the instance that you want to make the AMI with
2. Click Actions &gt; Image and click Create Image
3. Configure the image, which includes configuring the size of the EBS corresponding to the image
4. Create the image

### Usage

1. Find the AMI that you want to launch an instance with
2. Click launch
3. Configure the EC2 instance
4. Launch the instance



