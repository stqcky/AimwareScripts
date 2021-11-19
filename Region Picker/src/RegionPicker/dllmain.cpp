#include <Windows.h>
#include <iostream>
#include "RegionPicker.h"

DWORD WINAPI MainThread(HMODULE hModule) {
	AllocConsole();
	SetConsoleTitleA("region picker");
	FILE* f;
	freopen_s(&f, "CONOUT$", "w", stdout);

	while (!GetAsyncKeyState(VK_NUMPAD0)) {}

	if (f) fclose(f);
	FreeConsole();
	FreeLibraryAndExitThread(hModule, 0);

	return 0;
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
#ifdef DEBUG
	if (ul_reason_for_call == DLL_PROCESS_ATTACH) {
		HANDLE hThread = CreateThread(nullptr, 0, (LPTHREAD_START_ROUTINE)MainThread, hModule, 0, nullptr);
		if (hThread) {
			CloseHandle(hThread);
		}
	}
#endif

	return TRUE;
}
