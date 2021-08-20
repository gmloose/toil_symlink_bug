Symlink creation error when step fails
======================================


Problem description
-------------------

In certain situations, when a step fails with a non-zero exit status, Toil tries to create symbolic links to a temporary directory and the files inside it. This fails with a FileExistsError exception.
What seems to happen is the following:
  1. Create a symbolic link to a temporary directory.
  2. Create a symbolic link to a file in the temporary directory, **using the symbolic link created in the previous step**.
This second step will obviously fail; the link would overwirte the file in the temporary directory, because the link created in the first step will be dereferenced.

Or, conceptually:
  1. `ln -s /tmp/dir dir`
  2. `ln -s /tmp/dir/file dir/file`

It is not exactly clear under which circumstances Toil tries to create these symbolic links. It appears that the following pre-conditions have to be met:
  1. The workflow needs to contain more than one step.
  2. The second (or last?) step must fail.
  3. The failing steps must have more than one input parameter, but these input parameters don't have to be used.


Demonstration
-------------

The workflow consists of two steps. The first step will select the first entry from a list of directories, and pass that entry as input to the second step. The second step will simply generate an exit status 1. The extra input parameter `min_separation` is not used, but the error only occurs when it is specified. The workflow validates without warnings and runs without errors using `cwltool`. When using `toil-cwl-runner`, I get a `WorkflowException` due to an unhandled `FileExistsError` exception. You can run the workflow as follows:

    $ toil-cwl-runner workflow.cwl job.json


Software versions being used
----------------------------
    python : 3.6.9
    toil   : 5.4.0-87293d63fa6c76f03bed3adf93414ffee67bf9a7
    cwltool: 3.0.20201203173111

