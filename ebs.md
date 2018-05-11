# Elastic Block Store

[https://qwiklabs.com/focuses/404?parent=catalog](https://qwiklabs.com/focuses/404?parent=catalog)

* Provides **persistent block level storage volumes** for use with Amazon EC2 instances
* Automatically replicated within it's AZ \(redundancy\)
* Can be scaled up and down
* Data persists during lifetime and can be transported between virtual machines

### Creation Steps

1. **Creating a EBS volume**
   1. Services &gt; EC2 &gt; Volumes
   2. Set Name and Tag \(recommended\)
   3. Remember the AZ
   4. Click _Create Volume_
      1. IOPS - Inputs/Outputs per second
      2. Snapshot ID - allows a previous snapshot to be restored onto the new volume
      3. Encryption - automatic encryption for data
   5. Confirm and create
2. **Attach EBS to an EC2 instance** 
   1. Wait till the volumes shows a state of _available_
   2. Name the volume
   3. Click _Attach Volume_ \(under Actions\)
   4. Select the running instance
   5. Attach

### Making a Snapshot

* Incremental backups
* Only the blocks on the device that have changed after your most recent snapshot are saved

* Click _Create Snapshot_ \(under Actions\)

* Configure the snapshot
* Confirm and create

#### Restoring a Snapshot

1. Check the snapshot that you want to restore
2. Select Actions &gt; Create Volume
3. Configure the new volume

### Modifying the EBS Volume

1. Click _Volumes_ on the left navigation pane
2. Check the volume
3. Click _Modify Volume_ \(under Actions\)
4. Change the configuration
5. Click modify, confirm



