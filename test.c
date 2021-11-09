/**
 * @file test.c
 *
 * @brief A test file
 */

#include <mpi.h>
#include <stdio.h>

/**
 * @brief the @c main function.
 *
 * This is the entry point of the program, and the only function in this dummy test.
 *
 * @param argc the number of arguments
 * @param argv the vector of arguments
 *
 * @return the exit code
 */
int main(int argc, char** argv) {
	int world_size;
	int world_rank;
	char processor_name[MPI_MAX_PROCESSOR_NAME];
	int name_len;

	MPI_Init(NULL, NULL);
	MPI_Comm_size(MPI_COMM_WORLD, &world_size);
	MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
	MPI_Get_processor_name(processor_name, &name_len);

	printf("Hello world from processor %s, rank %d out of %d processors\n",
	       processor_name, world_rank, world_size);

	MPI_Finalize();
}
