#include "RegionPicker.h"
#include <unordered_map>
#include <iostream>
#include <stdio.h>
#include <stdarg.h>
#include "protobuf/cstrike15_gcmessages.pb.h"

void printToConsole(const char* format, ...) {
#ifdef DEBUG
	va_list arg;
	va_start(arg, format);
	vprintf(format, arg);
	va_end(arg);
#endif
}

char* stringifyId(uint32_t id) {
	static char* strId = new char[5];

	strId[0] = id >> 16;
	strId[1] = id >> 8;
	strId[2] = id;
	strId[3] = id >> 24;
	strId[4] = '\0';

	return strId;
}

void hashDatacenters(uint32_t* allowedDatacenters, std::unordered_set<uint32_t>* hashedDatacenters) {
	for (int i = 0; auto datacenter = allowedDatacenters[i]; i++) {
		hashedDatacenters->insert(datacenter);
	}
}

void* ModifyDatacenterPingData(const void* pubData, uint32_t cubData, uint32_t* allowedDatacenters) {
	static uint8_t* buffer = nullptr;

	if (buffer) {
		free(buffer);
	}

	printToConsole("Called ModifyDatacenterPingData\n");

	CMsgGCCStrike15_v2_MatchmakingClient2ServerPing message;

	if (!message.ParseFromArray((void*)(((uintptr_t)pubData) + 8), cubData - 8)) {
		return nullptr;
	}

	std::unordered_set<uint32_t> hashedAllowedDatacenters;
	hashDatacenters(allowedDatacenters, &hashedAllowedDatacenters);

	for (int i = 0; i < message.data_center_pings_size(); i++) {
		DataCenterPing* datacenter = message.mutable_data_center_pings(i);

		if (datacenter->has_ping() && datacenter->has_data_center_id()) {
			bool isDatacenterAllowed = hashedAllowedDatacenters.find(datacenter->data_center_id()) != hashedAllowedDatacenters.end();
			datacenter->set_ping(isDatacenterAllowed ? 10 : 500);
			printToConsole("%s [%u] - %s\n", stringifyId(datacenter->data_center_id()), datacenter->data_center_id(), (isDatacenterAllowed ? "allowed" : "rejected"));
		}
	}

	size_t size = message.ByteSizeLong() + 8;

	buffer = (uint8_t*)malloc(size);
	std::memcpy(buffer, pubData, 8);

	if (message.SerializeToArray(buffer + 8, size - 8)) {
		return buffer;
	}

	return nullptr;
}