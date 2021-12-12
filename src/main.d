module src.main;

nothrow @nogc:
// Types
alias TickType_t = uint;
alias BaseType_t = int;
alias UBaseType_t = uint;
alias TimerHandle_t = void*;
alias IWDG_HandleTypeDef = uint;
alias HAL_StatusTypeDef = int;
alias GPIO_TypeDef = uint;
// xTimer
enum tmrCOMMAND_START = cast(BaseType_t)1;
enum tmrCOMMAND_DELETE = cast(BaseType_t)5;
extern (C) TickType_t xTaskGetTickCount() @system;
extern (C) alias TimerCallbackFunction_t = void function(TimerHandle_t xTimer);
extern (C) TimerHandle_t xTimerCreate(const(char)* pcTimerName, TickType_t xTimerPeriodInTicks, UBaseType_t uxAutoReload, void* pvTimerID, TimerCallbackFunction_t pxCallbackFunction ) @system;
extern (C) BaseType_t xTimerGenericCommand( TimerHandle_t xTimer, BaseType_t xCommandID, TickType_t xOptionalValue, BaseType_t * pxHigherPriorityTaskWoken, TickType_t xTicksToWait ) @system;
pragma(inline, true) extern (D) alias xTimerStart  = function(xTimer, xTicksToWait) => xTimerGenericCommand(xTimer, tmrCOMMAND_START, xTaskGetTickCount(), null, xTicksToWait);
pragma(inline, true) extern (D) alias xTimerDelete = function(xTimer, xTicksToWait) => xTimerGenericCommand(xTimer, tmrCOMMAND_DELETE, 0U, null, xTicksToWait);
// IWDG
extern (C) HAL_StatusTypeDef HAL_IWDG_Refresh(IWDG_HandleTypeDef* hiwdg) @system;
extern (C) extern __gshared IWDG_HandleTypeDef hiwdg;
// GPIO
extern (C) void HAL_GPIO_TogglePin(GPIO_TypeDef* GPIOx, ushort GPIO_Pin) @system;
enum PERIPH_BASE = 0x40000000UL;
enum AHB1PERIPH_BASE = PERIPH_BASE + 0x00020000UL;
enum GPIOA_BASE = AHB1PERIPH_BASE + 0x0000UL;
enum ushort GPIO_PIN_5 = cast(ushort)0x0020;
enum GPIOA = cast(GPIO_TypeDef*)GPIOA_BASE;
enum LD2_GPIO_Port = GPIOA;
enum LD2_Pin = GPIO_PIN_5;
// CMSIS
extern (C) uint osDelay(uint) @system;

// 500msごとにコールバックされる
extern (C) void onLEDTim500ms(TimerHandle_t xTimer) @trusted
{
	// Lチカ
	HAL_GPIO_TogglePin(LD2_GPIO_Port, LD2_Pin);
}

extern (C) void D_main() @trusted
{
	// タイマーの作成・破棄
	auto tim500ms = xTimerCreate("LED500MS", 500, 1, null, &onLEDTim500ms);
	scope (exit)
		xTimerDelete(tim500ms, 0);
	// タイマーの開始
	xTimerStart(tim500ms, 0);
	while (1)
	{
		// ウォッチドッグを蹴る
		HAL_IWDG_Refresh(&hiwdg);
		// タスクスイッチする
		osDelay(1);
	}
}
