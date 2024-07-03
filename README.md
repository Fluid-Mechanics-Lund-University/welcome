## A Tutorial on Using Supercomputers for New PhD and Internship Students

Welcome to our tutorial designed specifically for new PhD and internship students! This guide aims to introduce you to the basics of using supercomputers, providing you with the essential knowledge and skills needed to effectively utilize these powerful computational resources for your research.

This tutorial covers the usage guide for three specific clusters: Tetralith, Dardel, and LUMI. For each cluster, you will learn how to make OpenFOAM work for you. Tutorials might include using built-in installations, as well as building your own OpenFOAM.

<span style="color: red;">Students may have questions about creating accounts, setting up connections, and transferring files. Please note that this tutorial does not cover how to gain access to the supercomputer. Instead, it focuses exclusively on how to effectively use OpenFOAM on supercomputers. For information on accessing the supercomputer, please refer to the emails from the supercomputer administrators and visit their official websites.</span>

<span style="color: blue;">After getting access to the super computer, you can copy this tutorial repository to the supercomputer. Some template job scripts are attached. Read, modify and submit them to see if they works.</span>

## Tetralith, Dardel, and LUMI Clusters

### Tetralith (Not valid anymore)

We take OpenFOAM-10 as an example

1. Load the relevant environment:
   ```bash
   module load OpenFOAM/10-opt-int32-hpc1-intel-2023a-eb
   source $FOAM_BASHRC
   ```

2. If you are going to compile your own program, load the compiling modules before loading OpenFOAM
   ```bash
    module load buildenv-intel/2023a-eb
    module load OpenFOAM/10-opt-int32-hpc1-intel-2023a-eb
    source $FOAM_BASHRC
   ```

Please refer to [this link](https://www.nsc.liu.se/software/installed/tetralith/OpenFOAM/) for mre information about loading other versions of OpenFOAM.
For more information regarding job scripts, read [the official guide](https://www.nsc.liu.se/support/batch-jobs/introduction/).

3. A simple test: some jobscripts are provided in jobTet. Transfer them to the supercomputer and go to each directiory and submit the job
   ```bash
   sbatch <jobScriptName>
   ```

Please check each script, you can see that we need to
- Specify the required resources, including time, memory, cores/nodes.
- Load the environment
- Execute the CFD program at last

If everything goes well, you will see the result directories (0.1, 0.2, ...) in all tests.



### Dardel 

#### Built-in installation (recommended)
Dardel has installed both OpenFOAM-7 and OpenFOAM-10. To load OpenFOAM modules, execute
```bash
module load PDC &&
module load openfoam/7 ## change to 10 if necessary, other versions might work but have not been tested
source $FOAM_BASHRC
```

#### Test
Some jobscripts are provided in jobDd. Transfer them to the supercomputer and go to each directiory and submit the job
```bash
   sbatch <jobScriptName>
```

Please check each script, you can see that we need to
- Specify the required resources, including time, memory, cores/nodes.
- Load the environment
- Execute the CFD program at last

If everything goes well, you will see the result directories (0.1, 0.2, ...) in all tests.

#### read if you are interested in install your own OpenFOAM
1. Download and install OpenFOAM
```bash
   ### First, CREATE A FOLDER and ENTER IT. OpenFOAM will be installed in this folder.
   module load PDC
   export MPI_ROOT=$CRAY_MPICH_BASEDIR/gnu/12.3
   git clone https://github.com/OpenFOAM/ThirdParty-7.git ## change to other versions if necessary
   git clone https://github.com/OpenFOAM/OpenFOAM-7.git  ## change to other versions if necessary
   cd OpenFOAM-7
   sed -i "s/WM_MPLIB=SYSTEMOPENMPI/WM_MPLIB=SGIMPI/g" etc/bashrc
   source etc/bashrc
   cd ../ThirdParty-7
   ./Allwmake -j >& log.Allwmake& &&
   wmRefresh &&
   cd ../OpenFOAM-7
   ./Allwmake -j >& log.Allwmake&

```

Remember, run 
```bash
$WM_PROJECT_DIR/etc/bashrc 
```
to know YOUR BASHRC FILE LOCATION. Record the output for future usage.

2. Use your own installation
Run
```bash
module load PDC &&
export MPI_ROOT=$CRAY_MPICH_BASEDIR/gnu/12.3 &&
source <YOUR BASHRC FILE LOCATION>
```
It is suggested to set this as an alias, or put it in your job script templates.



### LUMI

#### Install your own OpenFOAM
1. Load the relevant environment.

1.1. For OpenFOAM-10
```bash
module load LUMI/23.09  partition/C
module load OpenFOAM/10-cpeGNU-23.09-20230119
```

1.2. For OpenFOAM-7

No official support for OpenFOAM-7 is available, to compile from scratch

1.2.1 Download OpenFOAM-7
```bash
### go to your working directory and then execute the following
mkdir build
cd build
mkdir OpenFOAM-7
cd OpenFOAM-7
git clone https://github.com/OpenFOAM/OpenFOAM-7.git
git clone https://github.com/OpenFOAM/ThirdParty-7.git
```

1.2.2 Load the environment and compile
```bash
module load LUMI/23.09 && 
module load OpenMPI/4.1.6-cpeGNU-23.09 &&
source OpenFOAM-7/etc/bashrc
cd ThirdParty-7
./Allwmake -j &&
wmRefresh &&
cd ..
cd OpenFOAM-7
./Allwmake -j 
```
If you see some error output, try it again.
```bash
./Allwmake -j
```

#### Test
Some jobscripts are provided in jobLUMI. Transfer them to the supercomputer and go to each directiory and submit the job
   ```bash
   sbatch <jobScriptName>
   ```

Please check each script, you can see that we need to
- Specify the required resources, including time, memory, cores/nodes.
- Load the environment
- Execute the CFD program at last

If everything goes well, you will see the result directories (0.1, 0.2, ...) in all tests.



### Setting up working directories

#### Steps on Setting Up Environment Variables and Aliases


##### 1. Open Your Shell Configuration File
Open your `.bashrc` with `vim`:

```bash
vim ~/.bashrc
```


##### 2. Add Environment Variables and Aliases
Add the following lines:

```bash
# Define the directory for job scripts, REMEMBER TO CHANGE TO YOUR ROUTES
export jobScripts="/users/zhouyuch/jobScripts"

# Alias to quickly navigate to the project working directory
alias proj="cd /scratch/project_465000924/yuchen"

# Define the location of the project working directory
export projLoc="/scratch/project_465000924/yuchen"
```

Note:
- Use variable names (jobScripts etc.) that is easy to remember for you!
- Replace my route with your route.

##### 3. Save and Close the File
To save and exit in `vim`, press `ESC`, then type `:wq` and press `ENTER`.

##### 4. Apply the Changes
Run the following command to apply the changes:

```bash
source ~/.bashrc
```

#### Usage Examples

##### Navigating to the Project Directory
```bash
proj
```

##### Accessing Job Scripts Directory
```bash
ls $jobScripts
# or 
cp  $jobScripts/<a script your want> <target position>
```

### Uploading and downloading files
#### Simple SCP Tutorial for New PhD Students

Here is a quick tutorial on how to use `scp` (secure copy protocol) to upload and download files from the server. This guide will help you set up your environment and perform basic file transfers.

#### Setting Up Your Environment

First, you'll need to set up some environment variables and aliases in your shell configuration file (e.g., `.bashrc`, `.zshrc`) in your LOCAL COMPUTER. Add the following lines to your configuration file:

```bash
export lumiyuchenflash="zhouyuch@lumi.csc.fi:/pfs/lustref1/flash/project_465000924/yuchen"
alias lumi="ssh zhouyuch@lumi.csc.fi"
```


Note:
- Use variable names (jobScripts etc.) that is easy to remember for you!
- Replace my route with your route.

After adding these lines, make sure to source your configuration file to apply the changes:

```bash
source ~/.bashrc  # or source ~/.zshrc if you're using zsh
```

#### Accessing the Server

To access the server, you have two options:

1. **Direct SSH**:
    ```bash
    ssh zhouyuch@lumi.csc.fi
    ```

2. **Using the alias**:
    ```bash
    lumi
    ```

Both commands will log you into the server.

#### Transferring Files with SCP

##### Uploading Files to the Server

To upload files to the server, use the `scp` command with the `-r` option to recursively copy directories. Here's the general format:

```bash
scp -r <files_to_be_transferred> $lumiyuchenflash
```

##### Downloading Files from the Server

To download files from the server to your local machine, reverse the order of the source and destination:

```bash
scp -r $lumiyuchenflash/<files_to_be_transferred> <local_destination>
```

#### Examples

##### Upload Example

To upload a directory named `my_data` to the server:

```bash
scp -r my_data $lumiyuchenflash
```

In this command, $lumiyuchenflash is an environment variable that holds the destination path on the server. This variable is set to zhouyuch@lumi.csc.fi:/pfs/lustref1/flash/project_465000924/yuchen, which specifies the server address and the directory where the files will be uploaded.

##### Download Example

To download a directory named `project_results` from the server to your local `~/Downloads` directory:

```bash
scp -r $lumiyuchenflash/project_results ~/Downloads
```

##### Summary

- **Set up environment variables and aliases** in your shell configuration file.
- **Use `ssh` or the `lumi` alias** to access the server.
- **Use `scp -r`** to upload or download files between your local machine and the server.

By following these steps, you should be able to easily transfer files to and from the server. If you encounter any issues, feel free to reach out for help. Happy coding!

#### Something to note
##### Note counts
- **Tetralith**: Each node typically has 32 cores.
- **Dardel and LUMI**: Each node typically has 128 cores.
- Suitable for large computational tasks.

##### Use Shared Nodes for Smaller Cases
- Shared nodes allow multiple users to share the same node, managed automatically by the supercomputer.
- Ideal for smaller tasks that don't require an entire node.

##### Billing Calculation
- Based on core hours: if you use N cores for M hours, your usage is billed as N*M core hours.
- For shared nodes, billing may also consider memory usage. Generally, 2 GB of memory usage is associated with 1 core. If you allocate 64 GB of memory but request only 2 cores, you will be billed as if you are using 32 cores.

##### Node Selection in LUMI
- If your case requires fewer than 512 cores, consider submitting it to small nodes (shared nodes) rather than standard nodes (entire nodes). This can sometimes be faster.
