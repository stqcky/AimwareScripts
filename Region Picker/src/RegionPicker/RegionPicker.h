#include <cstdint>
#include <unordered_set>

void printToConsole(const char* format, ...);
char* stringifyId(uint32_t id);
void hashDatacenters(uint32_t* allowedDatacenters, std::unordered_set<uint32_t>* hashedDatacenters);

extern "C" {
	__declspec(dllexport) void* ModifyDatacenterPingData(const void* pubData, uint32_t cubData, uint32_t* allowedDatacenters);
}